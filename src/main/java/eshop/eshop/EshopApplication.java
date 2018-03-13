package eshop.eshop;

import eshop.eshop.model.User;
import eshop.eshop.model.UserType;
import eshop.eshop.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.JstlView;

import javax.swing.plaf.basic.BasicEditorPaneUI;

@SpringBootApplication
public class EshopApplication implements CommandLineRunner{

@Autowired
	UserRepository userRepository;


	public static void main(String[] args) {
		SpringApplication.run(EshopApplication.class, args);
	}


	@Bean

	public ViewResolver viewResolver(){
		InternalResourceViewResolver bean  = new InternalResourceViewResolver();
		bean.setViewClass(JstlView.class);
		bean.setPrefix("/WEB-INF/");
		bean.setSuffix(".jsp");
		return bean;
	}


	@Override
	public void run(String... strings) throws Exception {

		User user = userRepository.findUserByEmail("angel@mail.com");
		if (user==null){
		User admin = User.builder()
				.name("Angela")
				.email("angel@mail.com")
				.password(new BCryptPasswordEncoder().encode("12"))
				.type(UserType.ADMIN).build();
		userRepository.save(admin);
		}
	}
}
