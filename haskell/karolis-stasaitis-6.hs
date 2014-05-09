import System.Environment
import Data.Function
import Data.List

-- Types --
type Layout = [String]
type Coords = (Int, Int)
type TestCase = (String, [String])
type TestResults = [TestResult]
type TestResult = (String, Int)

-- Keyboard Layout Constant -- 
keyboard_layout = ["qwertyuiop", "asdfghjkl", "zxcvbnm"]

-- Helper Functions --
compareCase (a1, b1) (a2, b2)
  | b1 < b2 = LT
  | b1 > b2 = GT
  | b1 == b2 = compare a1 a2

getDistanceDifference :: (Coords, Coords) -> Int
getDistanceDifference coords = abs(fst(fst coords) - fst(snd coords)) + abs(snd(fst coords) - snd(snd coords))

-- Input/Output Helper Functions --
disectInputString :: String -> [TestCase]
disectInputString inputString = zip (map(head) (tail (map(words) (lines inputString)))) (map(drop 2) (tail (map(words) (lines inputString))))

concatOutputString :: [TestResults] -> String
concatOutputString testResults = intercalate "\n" $ map (testCaseResultString) testResults

testCaseResultString :: TestResults -> String
testCaseResultString testResult = intercalate " " $ map (testCasePartResultString) testResult

testCasePartResultString :: TestResult -> String
testCasePartResultString testResultPart = intercalate " " [fst testResultPart, show (snd testResultPart)]

-- Main Functions --
testCase :: Layout -> TestCase -> TestResults
testCase layout testCases = sortBy compareCase (map (getDistanceBetweenWords layout (fst testCases)) (snd testCases))

getDistanceBetweenWords :: Layout -> String -> String -> (String, Int)
getDistanceBetweenWords layout originalWord referenceWord = (referenceWord, sum (map (getDistanceDifference) (zip (getCoordsForWord layout originalWord) (getCoordsForWord layout referenceWord))))

getCoordsForWord :: Layout -> String -> [Coords]
getCoordsForWord layout word = map (getCoordsForLetter layout 0) word

getCoordsForLetter :: Layout -> Int -> Char -> Coords
getCoordsForLetter layout index letter
	| getCoordForLetterInRow (head layout) 0 letter /= -1	= (getCoordForLetterInRow (head layout) 0 letter, index)
	| otherwise												= getCoordsForLetter (drop 1 layout) (1 + index) letter

getCoordForLetterInRow :: String -> Int -> Char -> Int
getCoordForLetterInRow layoutRow index letter
	| length layoutRow == 0		= -1
	| letter == head layoutRow	= index
	| otherwise					= getCoordForLetterInRow (drop 1 layoutRow) (1 + index) letter

-- Program Flow --
main :: IO ()
main = do
	input <- readFile "in.txt"
	writeFile "out.txt" (concatOutputString(map(testCase keyboard_layout) (disectInputString input)))