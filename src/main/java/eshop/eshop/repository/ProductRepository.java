package eshop.eshop.repository;

import eshop.eshop.model.Product;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ProductRepository extends JpaRepository<Product,Integer> {


    List<Product> findProductsByBrandId(int id);
    List<Product> findProductsByCategoryId(int id);
}
