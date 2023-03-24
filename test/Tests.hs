import Test.QuickCheck
import Html

prop_p :: String -> Bool
prop_p content =
  let
    paragraph = p_ content
    expected = "<p>" <> content ++ "</p>"
  in
     show paragraph == expected

main :: IO ()
main = quickCheck prop_p
