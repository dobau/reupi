// Chamada a webservice sem usar framework axis ou jax-ws

    public static String getString() throws MalformedURLException, IOException {

        // Code to make a webservice HTTP request
        String responseString = "";
        String outputString = "";
        String wsURL = "https://apphom.viafacil.com.br/wsvp/ValePedagio";
        URL url = new URL(wsURL);
        URLConnection connection = url.openConnection();
        HttpURLConnection httpConn = (HttpURLConnection) connection;
        ByteArrayOutputStream bout = new ByteArrayOutputStream();
        String xmlInput = "<soapenv:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:cgmp=\"http://cgmp.com\"> "
                +"   <soapenv:Header/>                                                                                                                                                                                         "
                +"   <soapenv:Body>                                                                                                                                                                                            "
                +"      <cgmp:autenticarUsuario soapenv:encodingStyle=\"http://schemas.xmlsoap.org/soap/encoding/\">                                                                                                             "
                +"         <cnpj xsi:type=\"xsd:string\">123</cnpj>                                                                                                                                                   "
                +"         <login xsi:type=\"xsd:string\">ADMINISTRADOR</login>                                                                                                                                                  "
                +"         <senha xsi:type=\"xsd:string\">123</senha>                                                                                                                                                       "
                +"      </cgmp:autenticarUsuario>                                                                                                                                                                              "
                +"   </soapenv:Body>                                                                                                                                                                                           "
                +"</soapenv:Envelope>                                                                                                                                                                                          ";

        byte[] buffer = new byte[xmlInput.length()];
        buffer = xmlInput.getBytes();
        bout.write(buffer);
        byte[] b = bout.toByteArray();

        // Set the appropriate HTTP parameters.
        httpConn.setRequestProperty("Cache-Control", "no-cache");
        httpConn.setRequestProperty("Pragma", "no-cache");
        httpConn.setRequestProperty("Accept", "application/soap+xml, application/dime, multipart/related, text/*");
        httpConn.setRequestProperty("User-Agent", "Axis/1.4");
        httpConn.setRequestProperty("Content-Length", String.valueOf(b.length));
        httpConn.setRequestProperty("Content-Type", "text/xml; charset=utf-8");
        httpConn.setRequestProperty("SOAPAction", "\"\"");
        httpConn.setRequestMethod("POST");
        
        System.out.println(httpConn.getRequestProperties());
        
        httpConn.setDoOutput(true);
        httpConn.setDoInput(true);
        OutputStream out = httpConn.getOutputStream();
        // Write the content of the request to the outputstream of the HTTP
        // Connection.
        out.write(b);
        out.close();
        // Ready with sending the request.

        // Read the response.
        InputStreamReader isr = new InputStreamReader(httpConn.getInputStream());
        BufferedReader in = new BufferedReader(isr);

        // Write the SOAP message response to a String.
        while ((responseString = in.readLine()) != null) {
            outputString = outputString + responseString;
        }
        
        return outputString;
    }
