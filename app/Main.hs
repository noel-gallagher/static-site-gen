import Html

main = putStrLn (render myPage)

myPage :: Html
myPage = html_ "my page"
    (append_
        (h1_ "Hello")
        (append_
            (p_ "Welcome to")
            (p_ "my page")
        )
    )


