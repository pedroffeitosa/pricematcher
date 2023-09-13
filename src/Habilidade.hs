module Habilidade where

data Habilidade = Habilidade {
    id :: Int,
    descricao :: String,
    valor :: Int
}

toStringHabilidade :: Habilidade -> String
toStringHabilidade = descricao
