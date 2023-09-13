module Especializacao where

data Especializacao = Especializacao {
    id :: Int,
    descricao :: String,
    valor :: Int
}

toStringEspecializacao :: Especializacao -> String
toStringEspecializacao = descricao
