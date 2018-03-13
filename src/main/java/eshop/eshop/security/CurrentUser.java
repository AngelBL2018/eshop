package eshop.eshop.security;

import eshop.eshop.model.UserType;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.userdetails.User;



public class CurrentUser extends User {

   private eshop.eshop.model.User user;
    public CurrentUser(eshop.eshop.model.User user1) {
        super(user1.getEmail(),user1.getPassword(), AuthorityUtils.createAuthorityList(user1.getType().name()));
        this.user = user1;
    }


    public eshop.eshop.model.User getUser() {
        return user;
    }

    public int getId(){
        return user.getId();
    }

    public UserType getType()
    {
        return user.getType();
    }

}
