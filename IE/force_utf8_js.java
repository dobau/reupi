public class FixContentTypeFilter implements Filter {
    
    @Override
    public void init(FilterConfig chain) throws ServletException {}

    @Override
    public void doFilter(ServletRequest request, ServletResponse resp, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        
        chain.doFilter(req, resp);
        
        if (req.getRequestURI().toLowerCase().endsWith(EXT_JS)) {
            resp.setContentType("text/javascript;charset=UTF-8");
        }
    }

    @Override
    public void destroy() {}

}
