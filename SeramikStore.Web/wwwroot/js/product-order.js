

document.addEventListener("DOMContentLoaded", function () {

    var el = document.getElementById('sortable-products');

    var sortable = new Sortable(el, {
        handle: '.drag-handle',
        animation: 150
    });

    document.getElementById("btnSaveOrder")
        .addEventListener("click", function () {

            let orderList = [];
            let rows = el.querySelectorAll("tr");

            rows.forEach((row, index) => {
                orderList.push({
                    id: parseInt(row.dataset.id),
                    displayOrderNo: index + 1
                });
            });

            fetch('/api/product-order/update', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                credentials: 'same-origin', // 🔥 önemli
                body: JSON.stringify(orderList)
            })
                .then(r => r.json())
                .then(r => {
                    if (r.success) {
                        showSuccessToast("Sıralama kaydedildi");
                    }
                });

        });
});

/* 🔥 Bootstrap Toast helper */
function showSuccessToast(message) {
    let container = document.createElement("div");
    container.className = "toast-container position-fixed top-0 end-0 p-3";

    container.innerHTML = `
        <div class="toast text-bg-success" role="alert">
            <div class="toast-header text-bg-success">
                <strong class="me-auto">Success</strong>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="toast"></button>
            </div>
            <div class="toast-body">
                ${message}
            </div>
        </div>
    `;

    document.body.appendChild(container);

    let toastEl = container.querySelector('.toast');
    let toast = new bootstrap.Toast(toastEl, { delay: 3000 });
    toast.show();

    toastEl.addEventListener('hidden.bs.toast', () => {
        container.remove();
    });
}
