class AppConstants{
  static const String APP_NAME = "AutoPoint";
  static const int APP_VERSION = 1;

  static const String TOKEN = "APtoken";
  static const String CART_LIST = "Cart-list";
  static const String WISH_LIST = "Wish-list";
  static const String CART_HISTORY = "cart-history-list";

  static const String BASE_URL = "http://apilogin-001-site1.atempurl.com";

  //PRODUCT URI-S
  static const String GET_PRODUCT_ALL = "/api/Product";
  static const String GET_PRODUCT_BY_ID = "/api/Product/";
  static const String GET_PRODUCT_BY_NAME = "/api/Product/byName/";
  static const String GET_PRODUCT_BY_CATEGORY = "/api/Product/byCategory/";
  static const String POST_PRODUCT_CREATE = "/api/Product";
  static const String PUT_PRODUCT_UPDATE = "/api/Product/";
  static const String DELETE_PRODUCT = "/api/Product/";

  //USER URI-S
  static const String GET_USER_ALL = "/api/User";
  static const String GET_USER_BY_ID = "/api/User/";
  static const String GET_USER_BY_EMAIL = "/api/User/byEmail/";
  static const String GET_USER_BY_EMAIL_AND_PASSWORD = "/api/User/byEmailAndPassword/";
  static const String POST_USER_CREATE = "/api/User";
  static const String PUT_USER_UPDATE = "/api/User/";
  static const String DELETE_USER = "/api/User/";

  //ORDER URI-S
  static const String GET_ORDER_ALL = "/api/Order";
  static const String GET_ORDERS_BY_USER_ID = "/api/Order/byUserId/";
  static const String GET_ORDER_BY_ID = "/api/Order/";
  static const String POST_ORDER_CREATE = "/api/Order";
  static const String PUT_ORDER_UPDATE = "/api/Order/";
  static const String DELETE_ORDER = "/api/Order/";

  //COMMENT URI-S
  static const String GET_COMMENT_ALL = "/api/Comment";
  static const String GET_COMMENT_BY_ID = "/api/Comment/";
  static const String GET_COMMENT_BY_PRODUCT_ID = "/api/Comment/byProduct/";
  static const String POST_COMMENT_CREATE = "/api/Comment";
  static const String PUT_COMMENT_UPDATE = "/api/Comment/";
  static const String DELETE_COMMENT = "/api/Comment/";

  static const String USER_ADDRESS = "user_address";
  static const String GEOCODE_URI = "/api/Config/geocode-api";

  //CART URI-S
  static const String GET_CART_ALL = "/api/Cart";
  static const String GET_CART_BY_ID = "/api/Cart/";
  static const String GET_CART_BY_USER_ID = "/api/Cart/byUser/";
  static const String POST_CART_CREATE = "/api/Cart";
  static const String PUT_CART_UPDATE = "/api/Cart/";
  static const String DELETE_CART_BY_ID = "/api/Cart/";
  static const String DELETE_CART_BY_USER_ID = "/api/Cart/byUser/";
  static const String DELETE_CART_BY_USER_ID_AND_PRODUCT_ID = "/api/Cart/byUserAndProduct/";

  static const String EMAIL = "Email";
  static const String PASSWORD = "Password";

}