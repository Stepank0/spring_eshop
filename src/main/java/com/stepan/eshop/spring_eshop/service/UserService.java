package com.stepan.eshop.spring_eshop.service;

import com.stepan.eshop.spring_eshop.dto.UserDTO;
import org.springframework.security.core.userdetails.UserDetailsService;

public interface UserService extends UserDetailsService { // for security
    boolean save(UserDTO userDTO);
}
