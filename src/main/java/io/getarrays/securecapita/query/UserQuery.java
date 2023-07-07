package io.getarrays.securecapita.query;

public class UserQuery {
    public static final String INSERT_USER_QUERY = "insert into users(first_name,last_name,email,password) values (:firstName,:lastName,:email,:password);";
    public static final String COUNT_USER_EMAIL_QUERY = "select count(*) from users where email = :email;";
    public static final String INSERT_ACCOUNT_VERIFICATION_URL_QUERY = "insert into AccountVerification(user_id, url) values (:userId, :url);";
}
