module Data where

    data Data = Data {
        dia :: Int,
        mes :: Int,
        ano :: Int
    }

    getDia :: Data -> Int
    getDia = dia

    getMes :: Data -> Int
    getMes = mes
    
    getAno :: Data -> Int
    getAno = ano
    
    dataToString :: Data -> String
    dataToString d = show (dia d) ++ "/" ++ show (mes d) ++ "/" ++ show (ano d)

    dataEquals :: Data -> Data -> Bool
    dataEquals data1 data2 = (dia data1 == dia data2) &&
                            (mes data1 == mes data2) &&
                            (ano data1 == ano data2)
    