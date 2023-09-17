module Experiencia where

    data Experiencia = Experiencia {
        id :: Int,
        descricao :: String,
        valor :: Int
    }

    getDescricao :: Experiencia -> String
    getDescricao = descricao

    getValor :: Experiencia -> Int
    getValor = valor