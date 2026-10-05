# Warsztat: AI na rzeczywistym zadaniu zespołu (3 godziny)

**Cel:** poznać podstawy instrukcji projektowych i skills, a potem przejść przez jedno ograniczone zadanie z projektu C++: od zgłoszenia i dokumentacji do zmiany w kodzie, testów oraz oceny wyniku. Uczestnicy pracują w swoich repozytoriach z Claude.

**Przygotowanie przed warsztatem:** zespół wybiera jedno zadanie z Jira z możliwym do odtworzenia problemem i małym zakresem. Zapewnia dostęp do właściwych repozytoriów i dokumentacji, działające komendy build/test oraz informację, na jakich platformach trzeba sprawdzić zmianę. Prowadzący przygotowuje krótkie przykłady `CLAUDE.md`, `AGENTS.md`, Ponytail i Caveman oraz sprawdza dostępność `/claude-api prompt-audit` w używanej wersji Claude Code. Dobry przykład zadania: błąd zależny od x86/x64 w starszym kodzie C++; jeśli aktualne zadanie dotyczy innego obszaru, ćwiczenie podąża za nim.

| Czas | Praca na projekcie | Wynik |
|---|---|---|
| 0:00–0:10 | Zgłoszenie i punkt startowy. Ustalamy objawy, oczekiwane zachowanie i sposób odtworzenia problemu. | Jedno konkretne zadanie i sposób potwierdzenia problemu. |
| 0:10–0:30 | Podstawy na tym samym zadaniu: `CLAUDE.md`, `AGENTS.md`, Ponytail i Caveman. Na jednym pliku instrukcji uruchamiamy `/claude-api prompt-audit` dla używanego modelu, oceniamy raport i proponowany diff. Zachowujemy ważne reguły projektu; nie przyjmujemy zmian automatycznie. | Minimalne instrukcje projektu, przykład użycia skills i jedna uzasadniona decyzja z audytu. |
| 0:30–0:55 | Dajemy Claude tylko potrzebny kontekst: fragment dokumentacji, ścieżkę przez kod, zależności między repozytoriami i komendy build/test. Sprawdzamy wskazane przez model pliki i założenia. | Krótka mapa zadania i roboczy zestaw instrukcji dla Claude. |
| 0:55–1:15 | Z treści Jira i dokumentacji tworzymy kryteria akceptacji oraz plan zmiany: zachowanie wejścia/wyjścia, przypadki brzegowe, platformy, testy i ryzyka. | Kryteria akceptacji i lista sprawdzeń do wykonania. |
| 1:15–1:25 | Przerwa. |
| 1:25–2:20 | Wprowadzamy małą zmianę z pomocą Claude, stosując zasadę Ponytail. Czytamy diff, poprawiamy kod i testy, uruchamiamy właściwy build oraz testy. Dla zadania x86/x64 sprawdzamy szerokość typów, konwersje i zachowanie na dostępnych architekturach. | Zmiana w kodzie lub jasno nazwany bloker, z wynikami uruchomionych sprawdzeń. |
| 2:20–2:45 | Robimy krytyczny przegląd diffu: błędne założenia, regresje, bezpieczeństwo, przypadki brzegowe i zgodność z kryteriami. Poprawiamy znalezione problemy i ponawiamy dotknięte testy. | Lista ustaleń, poprawiony diff i dowody weryfikacji. |
| 2:45–3:00 | Zapisujemy 3–5 zasad, które pomogły przy tym zadaniu, we właściwych instrukcjach projektu lub krótkiej checkliście. Ustalamy, co jeszcze trzeba sprawdzić przed PR. | Materiał do ponownego użycia i konkretne następne kroki. |

**Zasada prowadzenia:** 20 minut na podstawy, potem praca uczestników na kodzie. Ponytail i Caveman pokazujemy jako konkretne, własne reguły pracy, a nie wbudowane możliwości każdego narzędzia. MCP i Jenkins pojawiają się tylko wtedy, gdy pomagają w wybranym zadaniu. Wyników nie uznajemy za zweryfikowane na architekturze lub środowisku, którego nie udało się uruchomić.