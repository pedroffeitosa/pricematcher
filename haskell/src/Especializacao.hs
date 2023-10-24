module Especializacao where

    data Especializacao = Especializacao {
        id :: Int,
        descricao :: String,
        multiplicador :: Float
    }

    getDescricao :: Especializacao -> String
    getDescricao = descricao

    getMultiplicador :: Especializacao -> Float
    getMultiplicador = multiplicador