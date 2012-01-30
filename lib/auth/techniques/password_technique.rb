module Auth
  class PasswordTechnique    
    # grab the params we want from this request
    def initialize(session)
      @username = session.username? ? session.username : nil
      @password = session.password? ? session.password : nil
    end
    
    # if we can successfully authenticate, return a User instance, otherwise nil
    def authenticate
      if username? and password?
        user = User.find_for_session(username)
        
        if user
          if user.active?
            if user.authenticate(@password)
              return user
            end
          end
          
          user.failed_authentication!
          user = nil
        end
      end
      
      nil
    end
    
    def password?
      !!@password
    end
    
    def persist?
      true
    end
    
    def username?
      !!@username
    end
    
    def username
      @username
    end
  end
end