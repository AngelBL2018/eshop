package eshop.eshop.controller;


import com.sun.org.apache.regexp.internal.RE;
import eshop.eshop.model.*;
import eshop.eshop.repository.*;
import eshop.eshop.security.CurrentUser;
import org.apache.commons.io.IOUtils;
import org.springframework.beans.CachedIntrospectionResults;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.MediaType;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.awt.*;
import java.io.*;
import java.util.LinkedList;
import java.util.List;

@Controller
public class MainController {


    @Value("${image.dir}")
    String imageDir;

    @Autowired
    PasswordEncoder passwordEncoder;
    @Autowired
    UserRepository userRepository;
    @Autowired
    CategoryRepository categoryRepository;
    @Autowired
    ProductRepository productRepository;
    @Autowired
    BrandRepository brandRepository;
    @Autowired
    CommentRepository commentRepository;

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String loginGet(ModelMap map) {
        map.addAttribute("newUser", new User());
        return "login";
    }

    @RequestMapping(value = "/signUp", method = RequestMethod.POST)
    public String signUpPost(@ModelAttribute(name = "newUser") User newUser) {
        newUser.setType(UserType.USER);
        newUser.setPassword(passwordEncoder.encode(newUser.getPassword()));
        userRepository.save(newUser);

        return "redirect:/login";

    }

    @RequestMapping(value = "/index", method = RequestMethod.GET)
    public String loginPost(@AuthenticationPrincipal UserDetails userDetails) {
        User user = ((CurrentUser) userDetails).getUser();
        if (user.getType() == UserType.ADMIN) {
            return "redirect:/admin";
        }
        return "redirect:/home";
    }


    @RequestMapping(value = "/admin", method = RequestMethod.GET)
    public String adminGet(ModelMap map) {
        map.addAttribute("category", new Category());
        map.addAttribute("brand", new Brand());
        map.addAttribute("product", new Product());
        map.addAttribute("categoryList", categoryRepository.findAll());
        map.addAttribute("brandList", brandRepository.findAll());
        return "admin";

    }

    @RequestMapping(value = "/addCategory", method = RequestMethod.POST)
    public String addCategory(@ModelAttribute("category") Category category) {
        categoryRepository.save(category);
        return "redirect:/admin";
    }


    @RequestMapping(value = "/addBrand", method = RequestMethod.POST)
    public String addBrand(@ModelAttribute("brand") Brand brand) {
        brandRepository.save(brand);
        return "redirect:/admin";
    }


    @RequestMapping(value = "/addProduct", method = RequestMethod.POST)
    public String addCategory(@ModelAttribute("product") Product product, @RequestParam("picture") MultipartFile multipartFile) throws IOException {

        File file = new File(imageDir);
        if (!file.exists()) {
            file.mkdirs();
        }
        String imageName = System.currentTimeMillis() + "_" + multipartFile.getOriginalFilename();
        multipartFile.transferTo(new File(imageDir + imageName));
        product.setPicUrl(imageName);
        productRepository.save(product);
        return "redirect:/admin";
    }


    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String home(@RequestParam(value = "brandId", required = false) Integer brandId, @RequestParam(value = "categoryId", required = false) Integer categoryId, ModelMap map, @AuthenticationPrincipal UserDetails userDetails) {


        map.addAttribute("isUserLogin", userDetails == null);

        if (brandId != null && brandId > 0) {
            map.addAttribute("ProductList", productRepository.findProductsByBrandId(brandId));
        } else if (categoryId != null && categoryId > 0) {
            map.addAttribute("ProductList", productRepository.findProductsByCategoryId(categoryId));

        } else {
            map.addAttribute("ProductList", productRepository.findAll());
        }


        map.addAttribute("categoryList", categoryRepository.findAll());
        map.addAttribute("BrandList", brandRepository.findAll());


        return "index";

    }

    @RequestMapping(value = "/image", method = RequestMethod.GET)
    public void image(HttpServletResponse response, @RequestParam("fileName") String fileName) throws IOException {
        InputStream inputStream = new FileInputStream(imageDir + fileName);
        response.setContentType(MediaType.IMAGE_JPEG_VALUE);
        IOUtils.copy(inputStream, response.getOutputStream());

    }

    @RequestMapping(value = "/productDetails")
    public String productDetails(@RequestParam("id") int id, ModelMap map) {
        map.addAttribute("Product", productRepository.findOne(id));

        map.addAttribute("categoryList", categoryRepository.findAll());
        map.addAttribute("BrandList", brandRepository.findAll());
        map.addAttribute("ProductList", productRepository.findAll());
        map.addAttribute("comment", new Comment());
        map.addAttribute("allComment", commentRepository.findCommentByProductId(id));
        return "product-details";
    }


    List<Product> list = new LinkedList<>();

    @RequestMapping(value = "/whishList", method = RequestMethod.GET)
    public String addToWhishList(ModelMap map, @RequestParam("id") int id, @AuthenticationPrincipal UserDetails userDetails) {
        if (userDetails != null) {
            User user = ((CurrentUser) userDetails).getUser();
            Product product = productRepository.findOne(id);
            user.getProducts().add(product);
            userRepository.save(user);

            return "redirect:/whishListNew";
        }

        return "redirect:/";

    }

    @RequestMapping(value = "/cart", method = RequestMethod.GET)
    public String card(ModelMap map, @RequestParam("id") int id, @AuthenticationPrincipal UserDetails userDetails) {
        if (userDetails != null) {
            User user = ((CurrentUser) userDetails).getUser();
            Product product = productRepository.findOne(id);
            user.getCartProducts().add(product);
            userRepository.save(user);


            return "redirect:/cartNew";
        }

        return "redirect:/";

    }

    @RequestMapping(value = "/delete", method = RequestMethod.GET)
    public String deleteCartItem(ModelMap map, @RequestParam("id") int id, @AuthenticationPrincipal UserDetails userDetails) {
        if (userDetails != null) {
            User user = ((CurrentUser) userDetails).getUser();
            Product product = productRepository.findOne(id);
            user.getCartProducts().remove(product);
            userRepository.save(user);


            return "redirect:/cartNew";
        }

        return "redirect:/";

    }

    @RequestMapping(value = "/deleteFromWhishList", method = RequestMethod.GET)
    public String deleteWhishListItem(ModelMap map, @RequestParam("productId") int productId, @AuthenticationPrincipal UserDetails userDetails) {
        if (userDetails != null) {
            User user = ((CurrentUser) userDetails).getUser();
            Product product = productRepository.findOne(productId);
            user.getProducts().remove(product);
            userRepository.save(user);

            return "redirect:/whishListNew";
        }

        return "redirect:/";

    }

    @RequestMapping(value = "/cartNew", method = RequestMethod.GET)
    public String cardNew(ModelMap map, @AuthenticationPrincipal UserDetails userDetails) {
        if (userDetails != null) {
            User user = ((CurrentUser) userDetails).getUser();

            map.addAttribute("cartProductList", user.getCartProducts());

            return "cart";
        }

        return "redirect:/";

    }

    @RequestMapping(value = "/whishListNew", method = RequestMethod.GET)
    public String whishListNew(ModelMap map, @AuthenticationPrincipal UserDetails userDetails) {
        if (userDetails != null) {
            User user = ((CurrentUser) userDetails).getUser();

            map.addAttribute("productList", user.getProducts());
            map.addAttribute("name", user.getName());

            return "whishList";
        }

        return "redirect:/";

    }

    @RequestMapping(value = "/addComment", method = RequestMethod.POST)
    public String addComment(@RequestParam("productId") String productId, @ModelAttribute("comment") Comment comment, @AuthenticationPrincipal UserDetails userDetails) {
        if (userDetails != null) {
            User user = ((CurrentUser) userDetails).getUser();
            if (comment.getName().equals(user.getName()) && comment.getEmail().equals(user.getEmail()) && !comment.getDescription().equals("")) {
                comment.setProductId(Integer.parseInt(productId));
                commentRepository.save(comment);
                return "redirect:/";
            }

        }
        return "redirect:/";

    }

}
