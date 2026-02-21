Chcę mieć program testujący poszczególne funkcje OpenGl.

Wiem, że nie jest możliwe przetestowanie wszystkich funkcji pojedynczo, więc potrzebuję je testować w grupach

Potrzebuję też tabelki w Readme w stylu 

| Function name      | Example1 <br/>OGL 1.1 | Example2 <br/>OGL 1.1 | Example3 <br/> OGL 1.2 |
|--------------------|------------------|------------------|------------------|
| glGenBuffers       | x                |                  |                  |
| glBindBuffer       | x                |                  |                  |
| glBufferData       | x                |                  |                  |
| glBufferSubData    |                  | x                |                  |
| glDeleteBuffers    |                  | x                |                  |
| glGetBufferSubData |                  |                  | x                |
| glMapBuffer        |                  |                  | x                |

ona ma się automatycznie generować poprzez odpowiedni skrypt, który będzie analizował kod źródłowy i aktualizował tabelkę w Readme.md(w jakikolwiek sposób który jest najprostszy - np. przez jakiś zewnęntrzy plik który będzie wcągany do Readme.md)

każdy z testów powinien być możliwie samodzielny

Na tyle ile to możliwe powinien korzystać tylko z funkcji OpenGL z testowanej wersji(każdy test musi mieć przypisaną wersję OpenGL, której funkcje wykorzystuje) lub jeśli się nie da - to korzystać z funkcji, które są dostępne w tej wersji.

Musi on być bardzo prosto cross-compilowalny `just arm` to testuje czy cross-compilacja na arm 32 bitowy działa bez problemu.

Najlepiej by testy coś wyświetlały 

Testy mają być napisane w Rust + np. Glutin do tworzenia kontekstu OpenGL(rust wymagany, glutin polecany, bo chyba on jest najbardziej popularny i łatwy w użyciu)

