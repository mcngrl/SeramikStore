(function () {
    'use strict';

    const apiUrl = 'https://api.turkiyeapi.dev/v2';
    const normalize = value => (value || '').trim().toLocaleUpperCase('tr-TR');
    const addOption = (select, value, text, id) => {
        const option = new Option(text, value);
        option.dataset.id = id || '';
        select.add(option);
        return option;
    };
    const reset = (select, message) => {
        select.length = 0;
        addOption(select, '', message);
        select.disabled = true;
    };
    const selectStoredValue = (select, value) => {
        const option = Array.from(select.options)
            .find(item => normalize(item.value) === normalize(value));
        if (option) option.selected = true;
        return option;
    };
    const getData = async path => {
        const fetchPage = async url => {
            const response = await fetch(`${apiUrl}${url}`);
            if (!response.ok) throw new Error('Adres verisi alınamadı.');
            return await response.json();
        };

        const firstPage = await fetchPage(path);
        const items = firstPage.data || [];
        const total = firstPage.meta?.total || items.length;

        // API en fazla 100 kayıt döndürür. Büyük ilçelerdeki tüm mahalleleri
        // göstermek için kalan sayfaları da sırayla alırız.
        while (items.length < total) {
            const separator = path.includes('?') ? '&' : '?';
            const nextPage = await fetchPage(`${path}${separator}offset=${items.length}`);
            const nextItems = nextPage.data || [];
            if (!nextItems.length) break;
            items.push(...nextItems);
        }

        return items;
    };

    const initialise = async () => {
        const province = document.querySelector('[data-turkiye-il]');
        const district = document.querySelector('[data-turkiye-ilce]');
        const neighborhood = document.querySelector('[data-turkiye-mahalle]');
        if (!province || !district || !neighborhood) return;

        const selectedProvince = province.dataset.selectedValue || province.value;
        const selectedDistrict = district.dataset.selectedValue || district.value;
        const selectedNeighborhood = neighborhood.dataset.selectedValue || neighborhood.value;

        const loadNeighborhoods = async (districtId, storedValue = '') => {
            reset(neighborhood, districtId ? 'Mahalle seçiniz' : 'Önce ilçe seçiniz');
            if (!districtId) return;

            const neighborhoods = await getData(`/districts/${districtId}/neighborhoods`);
            neighborhoods.forEach(item => addOption(neighborhood, item.name, item.name, item.id));
            neighborhood.disabled = false;
            selectStoredValue(neighborhood, storedValue);
        };

        const loadDistricts = async (provinceId, storedValue = '', neighborhoodValue = '') => {
            reset(district, provinceId ? 'İlçe seçiniz' : 'Önce il seçiniz');
            reset(neighborhood, 'Önce ilçe seçiniz');
            if (!provinceId) return;

            const districts = await getData(`/provinces/${provinceId}/districts`);
            districts.forEach(item => addOption(district, item.name, item.name, item.id));
            district.disabled = false;
            const selected = selectStoredValue(district, storedValue);
            if (selected) await loadNeighborhoods(selected.dataset.id, neighborhoodValue);
        };

        try {
            const provinces = await getData('/provinces');
            provinces.forEach(item => addOption(province, item.name, item.name, item.id));
            const selected = selectStoredValue(province, selectedProvince);
            if (selected) await loadDistricts(selected.dataset.id, selectedDistrict, selectedNeighborhood);

            province.addEventListener('change', () => loadDistricts(province.selectedOptions[0]?.dataset.id));
            district.addEventListener('change', () => loadNeighborhoods(district.selectedOptions[0]?.dataset.id));
        } catch (error) {
            reset(district, 'Adres verisi yüklenemedi');
            reset(neighborhood, 'Adres verisi yüklenemedi');
            console.error(error);
        }
    };

    document.readyState === 'loading'
        ? document.addEventListener('DOMContentLoaded', initialise)
        : initialise();
}());
