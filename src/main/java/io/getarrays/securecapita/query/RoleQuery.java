package io.getarrays.securecapita.query;

public class RoleQuery {
    public static final String INSERT_ROLE_TO_USER = "insert into UserRoles (user_id,role_id) values (:userId,:roleId);";
    public static final String SELECT_ROLE_BY_NAME_QUERY = "select * from Roles where name= :name;";
}
