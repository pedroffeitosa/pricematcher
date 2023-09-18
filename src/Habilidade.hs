module Habilidade where

    data Habilidade = Habilidade {
        id :: Int,
        descricao :: String,
        multiplicador :: Float
    }

    getDescricao :: Habilidade -> String
    getDescricao = descricao

    getMultiplicador :: Habilidade -> Float
    getMultiplicador = multiplicador