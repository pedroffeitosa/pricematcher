module Tecnologia where

    data Tecnologia = Tecnologia {
        nome :: String,
        valor :: Int
    }

    getNome :: Tecnologia -> String
    getNome = nome

    getValor :: Tecnologia -> Int
    getValor = valor
    
    tecEquals :: Tecnologia -> Tecnologia -> Bool
    tecEquals tec1 tec2 = nome tec1 == nome tec2
