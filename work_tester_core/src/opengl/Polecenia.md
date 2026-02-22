Chcę mieć program testujący poszczególne funkcje OpenGl.

Wiem, że nie jest możliwe przetestowanie wszystkich funkcji pojedynczo, więc potrzebuję je testować w grupach

każdy z testów powinien być możliwie samodzielny - ale z racji na ilość elementów dopuszczam grupowanie po nawet 30 albo nawet 50 funkcji jeśli są z  grubsza z tego samej wersji

Na tyle ile to możliwe powinien korzystać tylko z funkcji OpenGL z testowanej wersji(każdy test musi mieć przypisaną wersję OpenGL, której funkcje wykorzystuje) lub jeśli się nie da - to korzystać z funkcji, które są dostępne w tej wersji.

Musi on być bardzo prosto cross-compilowalny `just arm` to testuje czy cross-compilacja na arm 32 bitowy działa bez problemu.

Testy muszą zarządzać oknem i wyświetlać coś na nim przez około 1s

Skopiowałem katalog winit i glutin do repo, więc mogę być użyte jako popatrzenie jak to się robi przy ich użyciu gdy są błędy

