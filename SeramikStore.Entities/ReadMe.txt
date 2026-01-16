1) Entities      → DB'yi birebir temsil eder (Cart, OrderHeader)
2) DTOs          → SP result / input
3) Repository    → ADO.NET + SP Repository iş kuralı bilmez, sadece veri alır/verir
4) Services      → Service katmanı (iş kuralı burada)
5) Web           → ViewModel

✔️ Entity’ler:
Auto‑generated (senin tool’un)
Asla business logic yok
Sadece property

✔️ DTO’lar:
Elle yazılır
SP’ye göre şekillenir
Entity’den farklı olabilir (ve olmalı)

Yeni tablo yarat
1) Entity Creatoru çalıştır.