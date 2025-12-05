  - name: finance_campaigns_day
    description: "Gün bazında finansal metrikler ile reklam maliyetlerinin birleştirildiği mart modeli. Finans ekibinin kampanya bazlı günlük maliyet/marj analizini yapabilmesi için oluşturulmuştur."

    columns:
      - name: date
        description: "Gün bilgisi, modelin birincil zaman boyutu."
        tests:
          - not_null

      - name: ads_margin
        description: "Reklam maliyetleri düşüldükten sonra operasyonel marj. (operational_margin - ads_cost)"

      - name: average_basket
        description: "Günlük ortalama sepet büyüklüğü."

      - name: operational_margin
        description: "Satışlardan elde edilen operasyonel marj."

      - name: ads_cost
        description: "O gün gerçekleşen reklam harcaması toplamı."
        tests:
          - not_null

      - name: ads_impression
        description: "O gün reklamların aldığı gösterim sayısı."

      - name: ads_clicks
        description: "O gün yapılan reklam tıklama sayısı."

      - name: quantity
        description: "Gün içindeki toplam satılan ürün miktarı."

      - name: revenue
        description: "Gün içindeki toplam ciro."
        tests:
          - not_null

      - name: purchase_cost
        description: "Ürünlerin satın alma maliyeti toplamı."

      - name: margin
        description: "Satışlardan elde edilen marj (revenue - purchase_cost - shipping_fee - log_cost)."

      - name: shipping_fee
        description: "Günlük müşteriden alınan kargo ücreti."

      - name: log_cost
        description: "Lojistik maliyet."

      - name: ship_cost
        description: "Navlun / teslimat maliyeti (bu projede sabit 0)."
