module Habilidade where

    data Habilidade = Habilidade {
        id :: Int,
        descricao :: String,
        valor :: Int
    }

    getDescricao :: Habilidade -> String
    getDescricao = descricao

    getValor :: Habilidade -> Int
    getValor = valor