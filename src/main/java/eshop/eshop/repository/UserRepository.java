package eshop.eshop.repository;

import eshop.eshop.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<User,Integer> {
    public User findUserByEmailAndPassword(String email,String password);
    public User findUserByEmail(String email);
}
