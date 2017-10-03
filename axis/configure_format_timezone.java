             Field field;
             try {
                    field = CalendarSerializer.class.getDeclaredField("zulu");
                    field.setAccessible(true);
 
                    SimpleDateFormat brazilianTime = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS");
                    TimeZone tmz = TimeZone.getTimeZone("America/Sao_Paulo");
                    
                    brazilianTime.setTimeZone(tmz);
                    
                    field.set(null, brazilianTime);
             } catch (Exception e) {
                    e.printStackTrace();
             }
 
