module Especializacao where

    data Especializacao = Especializacao {
        id :: Int,
        descricao :: String,
        valor :: Int
    }

    getDescricao :: Especializacao -> String
    getDescricao = descricao

    getValor :: Especializacao -> Int
    getValor = valor