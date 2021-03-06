module ShopifyApp::LoginProtection
  def shopify_session
    if session[:shopify]
      begin
        # session[:shopify] set in LoginController#finalize
        ShopifyAPI::Base.activate_session(session[:shopify])
        yield
      ensure 
        ShopifyAPI::Base.clear_session
      end
    else
      session[:return_to] = request.fullpath
      redirect_to shopify_login_path
    end
  end
  
  def shop_session
    session[:shopify]
  end
end
