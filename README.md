<h1 align="center">Revenue Metrics for Video Game Sales (Mar-Dec 2022)</h1>

## 📝 Opis projektu

Projekt dotyczy przychodów ze sprzedaży gier wideo w okresie od marca do grudnia 2022 roku. Umożliwia on menedżerom produktu śledzenie dynamiki zmian przychodów oraz analizowanie czynników wpływających na te przychody.

## 🎯 Cele

✅ Obliczanie metryk finansowych – analiza MRR, nowych użytkowników, użytkowników, którzy zrezygnowali z płatności oraz ich wpływu na całkowite przychody 

✅ Segmentacja użytkowników – grupowanie użytkowników na podstawie wieku, języka, historii płatności 

✅ Identyfikacja trendów rynkowych – wykrywanie wzorców zakupowych i preferencji użytkowników na podstawie danych sprzedażowych

✅ Analiza czynników wpływających na przychody – identyfikacja kluczowych elementów, takich jak liczba użytkowników, płatności 

✅ Optymalizacja strategii biznesowej – wsparcie menedżerów produktu w podejmowaniu decyzji dotyczących cen i alokacji budżetu marketingowego 

✅ Wizualizacja wyników projektu w formie interaktywnego dashboardu


## 🛠 Technologie

🔹 SQL (PostgreSQL/DBeaver)

🔹 Tableau 


## 📊 Kluczowe metryki

1. **Monthly Recurring Revenue** (MRR) - kwota przychodu (revenue) w miesiącu kalendarzowym, ale tylko wtedy, kiedy przychód ten został uzyskany ze źródeł, które powtarzają się z miesiąca na miesiąc
2. **Paid Users** - liczba płacących użytkowników
3. **Average Revenue Per Paid User** (ARPPU) - średni przychód (revenue) na płacącego użytkownika. Jest on obliczany jako Revenue / Paid Users.
4. **New Paid Users** - liczba użytkowników, którzy zaczęli płacić w danym okresie
5. **New MRR** - MRR wygenerowany przez użytkowników, którzy stali się płacącymi użytkownikami w danym miesiącu
6. **Churned Users** - liczba użytkowników, którzy przestali płacić w danym okresie
7. **Users Retention Rate** (Cohort Analysis) - procent użytkowników, którzy pozostają aktywni w kolejnych okresach po pierwszej płatności, wskazujący zdolność produktu do utrzymania użytkowników w czasie
8. **Churned revenue** - całkowity przychód (revenue) w poprzednim okresie od wszystkich użytkowników, którzy przestali płacić
9. **Contraction MRR** - kwota, o którą zmniejszył się MRR z miesiąca na miesiąc. Jest on obliczany dla użytkowników, którzy zaczęli płacić mniej w bieżącym miesiącu
10. **Expansion MRR** - kwota, o którą zwiększył się MRR z miesiąca na miesiąc. Jest on obliczany dla użytkowników, którzy zaczęli płacić więcej w bieżącym miesiącu
11. **Customer LifeTime** - średni czas od pierwszej płatności do rezygnacji użytkownika. Czyli całkowity czas, przez który przeciętny użytkownik korzysta z produktu
12. **Customer Life Time Value** - średnia łączna kwota, jaką jeden użytkownik płaci za cały czas korzystania z produktu. Jest to całkowita kwota, którą przeciętny użytkownik płaci firmie

## 🏛 Tabele źródłowe

📌 games_paid_users - tabela zawierająca dane o użytkownikach (ID użytkownika, nazwa gry, język, wiek)

📌 projects_games_payments - tabela zawierająca dane o płatnościach użytkowników (ID użytkownika, nazwa gry, data płatności, przychód) 

📌 projekt II - zapytanie zawierające: miesiąc płatności, datę płatności, kwotę przychodu w USD, miesięczny MRR, poprzedni MRR, Expansion MRR, Contraction MRR, status nowego użytkownika, status rezygnacji



## 💡 Wyniki i wnioski

✅ W okresie od marca do grudnia 2022 roku całkowity przychód ze sprzedaży gier video wyniósł 63 141 $. W tym czasie łącznie 383 użytkowników dokonało zakupu, generując średni przychód na użytkownika (ARPPU) w wysokości 165 $

✅ MRR (Monthly Recurring Revenue) systematycznie rósł od marca (1 491 $) do października (9 344 $), po czym nieznacznie spadł w listopadzie i grudniu (8 425 $ i 8 440 $). Równolegle wzrastała liczba aktywnych użytkowników – z 43 w marcu do 199 w październiku, co świadczy o sukcesywnym przyciąganiu nowych klientów

✅ Gra 3 cieszyła się największym zainteresowaniem – zakupiło ją 373 użytkowników, co wygenerowało aż 62 850 $ przychodu. Gra 1 miała najmniejszą sprzedaż – 3 użytkowników i 69 $ przychodu. Może to świadczyć o braku dopasowania do rynku lub niewystarczającym marketingu

✅ Największy przychód wygenerowali użytkownicy w wieku 18–24 lata – 33 343 USD. Najmniejszy udział miała grupa wiekowa 39–44 lata, odpowiadając jedynie za 403 USD. Użytkownicy w wieku 14–24 lata wygenerowali łącznie 75% całkowitego przychodu, co czyni ich kluczowym segmentem docelowym

✅ Wrzesień charakteryzował się najwyższą retencją użytkowników w pierwszym miesiącu od rozpoczęcia płatności – 78,9%. Podobnie wysoką wartość osiągnięto w czerwcu – 77,8%. Najniższy poziom retencji odnotowano w kwietniu – zaledwie 22% użytkowników pozostało aktywnych w ósmym miesiącu od pierwszej płatności

✅ W listopadzie zaobserwowano największy odpływ przychodów, spowodowany rezygnacją 71 użytkowników, co przełożyło się na 2 800 $ utraconych wpływów. Mimo to, wzrost liczby nowych użytkowników oraz dodatkowe przychody od obecnych klientów (Expansion MRR) pozwoliły utrzymać stabilny poziom całkowitych przychodów
 

## 🔗 Link

# 👉   [![Tableau](https://img.shields.io/badge/Tableau-Dashboard-blue)](https://public.tableau.com/views/RevenuemetricsGAMESALES/RevenueMetrics?:language=en-GB&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)

![Opis](https://github.com/KatarzynaKrauza/Project-Revenue-metrics/blob/main/Revenue%20metrics.png)
