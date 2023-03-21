package com.stepan.eshop.spring_eshop.dao;


import com.stepan.eshop.spring_eshop.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<User, Long> {
    User findFirstByName(String name);
}
