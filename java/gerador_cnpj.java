-- Gerador de CNPJ em Java
    public static String geraCNPJ() {
        String cnpj = "";

        Random random = new Random();
        for (int i = 0;i < 12;i++) {
            cnpj += random.nextInt(9);
        }
        
        // Cria digitos
        int[] digitos = new int[14];
        for (int i = 0; i < 12;i++) {
            digitos[i] = Integer.parseInt(cnpj.substring(i, i+1));
        }

        digitos[12] = 11 - ((
                (digitos[0] * 5)+
                (digitos[1] * 4)+
                (digitos[2] * 3)+
                (digitos[3] * 2)+
                (digitos[4] * 9)+
                (digitos[5] * 8)+
                (digitos[6] * 7)+
                (digitos[7] * 6)+
                (digitos[8] * 5)+
                (digitos[9] * 4)+
                (digitos[10] * 3)+
                (digitos[11] * 2)
            ) % 11);


        if (digitos[12] > 9)
            digitos[12] = 0;

            digitos[13] = 11 - ((
                (digitos[0] * 6)+
                (digitos[1] * 5)+
                (digitos[2] * 4)+
                (digitos[3] * 3)+
                (digitos[4] * 2)+
                (digitos[5] * 9)+
                (digitos[6] * 8)+
                (digitos[7] * 7)+
                (digitos[8] * 6)+
                (digitos[9] * 5)+
                (digitos[10] * 4)+
                (digitos[11] * 3)+
                (digitos[12] * 2)
            ) % 11);

        if (digitos[13] > 9)
            digitos[13] = 0;

        return cnpj+digitos[12]+digitos[13];
    }