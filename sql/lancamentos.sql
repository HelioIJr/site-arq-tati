CREATE TABLE IF NOT EXISTS quartos_infantis (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid REFERENCES auth.users ON DELETE CASCADE,
  tipo text CHECK (tipo IN ('menino', 'menina')),
  data_nascimento date NOT NULL,
  categoria text CHECK (categoria IN ('esportes', 'conto de fadas', 'fundo do mar', 'heróis', 'bonecas', 'animais', 'espacial', 'princesas', 'super heróis')),
  comprimento numeric NOT NULL CHECK (comprimento > 0),
  largura numeric NOT NULL CHECK (largura > 0),
  altura numeric NOT NULL CHECK (altura > 0),
  descricao text,
  created_at timestamp with time zone DEFAULT timezone('utc'::text, now())
);

ALTER TABLE quartos_infantis ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Permitir acesso ao próprio usuário nos quartos infantis"
ON quartos_infantis
FOR ALL
USING (auth.uid() = user_id)
WITH CHECK (auth.uid() = user_id);