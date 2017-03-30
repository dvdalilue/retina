discretePoints :: Int -> Int -> Int -> Int -> Double -> [(Int,Int)]
discretePoints x1 y1 x2 y2 m =
    [(i,j) | i <- [x1..x2],
             j <- [y1..y2],
             fromIntegral (j - y1) >= m * fromIntegral (i - x1) - 0.5,
             fromIntegral (j - y1) <= m * fromIntegral (i - x1) + 0.5]

type Point = (Int, Int)

discretePoints' :: Point -> Point -> Double -> [Point]
discretePoints' (x1,y1) (x2,y2) m =  [(x, f x) | x <- [x1..x2]]
  where
    f x = round (fromIntegral (x - x1) * m) + y1