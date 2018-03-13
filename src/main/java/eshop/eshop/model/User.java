package eshop.eshop.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;

import javax.persistence.*;
import java.util.LinkedList;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Entity
@Table(name = "user")

public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column
    private int id;
    @Column
    private String name;
    @Column
    private String email;
    @Column
    private String password;
    @Column
    @Enumerated(EnumType.STRING)
    private UserType type;


    @ManyToMany(fetch = FetchType.EAGER)
    @JoinTable(
            name="user_product",
            joinColumns={@JoinColumn(name = "user_id", referencedColumnName = "id")},
            inverseJoinColumns={@JoinColumn(name = "product_id", referencedColumnName = "id")})
    private List<Product> products;


    @ManyToMany(fetch = FetchType.EAGER)
    @Fetch(value = FetchMode.SUBSELECT)
    @JoinTable(
            name="user_cart_product",
            joinColumns={@JoinColumn(name = "user_cartid", referencedColumnName = "id")},
            inverseJoinColumns={@JoinColumn(name = "product_cartid", referencedColumnName = "id")})
    private List<Product> cartProducts;
}
