// Problema de Loopback
public class AddrList
{
    public static void main(String[] args)
    {
        try
        {
            InetAddress loopback = InetAddress.getLoopbackAddress();
            dump("Loopback",loopback);
        }
        catch (Throwable t)
        {
            System.out.println("Unable to getLoopbackAddress()");
            t.printStackTrace();
        }

        try
        {
            InetAddress localhost = InetAddress.getLocalHost();
            dump("LocalHost",localhost);
        }
        catch (Throwable t)
        {
            System.out.println("Unable to getLocalHost()");
            t.printStackTrace();
        }

        try
        {
            InetAddress alladdr = InetAddress.getByName("0.0.0.0");
            dump("0.0.0.0",alladdr);
        }
        catch (Throwable t)
        {
            System.out.println("Unable to getLocalHost()");
            t.printStackTrace();
        }

        try
        {
            Enumeration<NetworkInterface> nets = NetworkInterface.getNetworkInterfaces();
            for (NetworkInterface iface : Collections.list(nets))
            {
                try
                {
                    System.out.println("DisplayName = " + iface.getDisplayName());
                    System.out.println("Name = " + iface.getName());

                    List<InetAddress> addrs = Collections.list(iface.getInetAddresses());
                    int i = 0;
                    for (InetAddress addr : addrs)
                    {
                        dump(Integer.toString(i++),addr);
                    }
                }
                catch (Throwable t)
                {
                    System.out.println("Unable to InetAddress for NetworkInterface: " + iface.getDisplayName());
                    t.printStackTrace();
                }
            }
        }
        catch (SocketException e)
        {
            System.out.print("Unable to get all network interfaces");
            e.printStackTrace();
        }
    }

    public static void dump(String type, InetAddress addr)
    {
        String header = String.format("[%s] InetAddress",type);
        try
        {
            System.out.println(header + " = " + addr);
            System.out.println(header + ".isAnyLocalAddress = " + addr.isAnyLocalAddress());
            System.out.println(header + ".isLinkLocalAddress = " + addr.isLinkLocalAddress());
            System.out.println(header + ".isLoopbackAddress = " + addr.isLoopbackAddress());
        }
        catch (Throwable t)
        {
            System.out.printf("[%s] Failed to list InetAddress details%n",type);
            t.printStackTrace();
        }

        try
        {
            header = String.format("[%s] InetSocketAddress",type);
            InetSocketAddress isockaddr = new InetSocketAddress(addr,8080);
            System.out.println(header + " = " + isockaddr);
            System.out.println(header + ".isUnresolved = " + isockaddr.isUnresolved());
        }
        catch (Throwable e)
        {
            e.printStackTrace();
        }
    }
}
