import Test.QuickCheck
import Test.Hspec
import Html

specialCharsToExclude :: [Char]
specialCharsToExclude = "<>&\"\'"

genStringWithoutConverted :: Gen String
genStringWithoutConverted = listOf $ elements $ filter (`notElem` specialCharsToExclude) [' ' .. '-']

prop_wrapInParagraph :: String -> Bool
prop_wrapInParagraph content =
  getStructureString (p_ content) == "<p>" <> content <> "</p>"

prop_wrapInHeader :: String -> Bool
prop_wrapInHeader title =
  getStructureString (h_ 1 title) == "<h1>" <> title <> "</h1>"

specEscapeChar :: (String, String) -> SpecWith ()
specEscapeChar (input, expected) = 
  it ("correctly escapes the character " ++ input) $
    escape input `shouldBe` expected 

main :: IO ()
main = hspec $ do 
  describe "html gen" $ do
    it "should wrap paragraphs" $
      property $ forAll genStringWithoutConverted prop_wrapInParagraph

    it "should wrap h1" $
      property $ forAll genStringWithoutConverted prop_wrapInHeader
    
    let escapeChars = [("<", "&lt"),
                       (">", "&gt"),
                       ("\"", "&quot"),
                       ("\'", "&#39"),
                       ("&", "&amp")]

    mapM_ specEscapeChar escapeChars

