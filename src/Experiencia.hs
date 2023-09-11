module Experiencia where

data Experiencia = Experiencia {
    id :: Int,
    descricao :: String,
    valor :: Int
}

toStringExperiencia :: Experiencia -> String
toStringExperiencia = descricao
