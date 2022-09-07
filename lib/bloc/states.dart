abstract class AppStates {}

class InitState extends AppStates {}

class LoadingState extends AppStates {}

class ChangeSuccess extends AppStates {}

class GetFinalPriceSuccess extends AppStates {}

class GetTokenSuccess extends AppStates {}

class GetTokenError extends AppStates {}

class GetOrderIdSuccess extends AppStates {}

class GetOrderIdError extends AppStates {}

class GetPaymentTokenSuccess extends AppStates {}

class GetPaymentTokenError extends AppStates {}

class GetRefCodeSuccess extends AppStates {}

class GetRefCodeError extends AppStates {}
