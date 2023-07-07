package io.getarrays.securecapita.service;

import io.getarrays.securecapita.domain.User;
import io.getarrays.securecapita.dto.UserDto;

public interface UserService {
    UserDto createUser(User user);
}
