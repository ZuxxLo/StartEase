class UserModel {
  late String _userID;
  late String _userUserName;
  late String _userFirstName;
  late String _userLastName;
  late String _userEmail;
  late String _userPassword;
  late String _userPhoneNumber;
  late String _userImageURL;
  late String _userBirthday;
  late String _userBirthplace;

  get getUserID => _userID;
  set setUserID(userID) => _userID = userID;

  get getuserUserName => _userUserName;
  set setuserUserName(userUserName) => _userUserName = userUserName;

  get getUserFirstName => _userFirstName;
  set setUserFirstName(userFirstName) => _userFirstName = userFirstName;

  get getUserLastName => _userLastName;
  set setUserLastName(userLastName) => _userLastName = userLastName;

  get getUserEmail => _userEmail;
  set setUserEmail(userEmail) => _userEmail = userEmail;

  get getUserPassword => _userPassword;
  set setUserPassword(usderPassword) => _userPassword = usderPassword;

  get getUserImageURL => _userImageURL;
  set setUserImageURL(userImageURL) => _userImageURL = userImageURL;

  get getuserPhoneNumber => _userPhoneNumber;
  set setuserPhoneNumber(userPhoneNumber) => _userPhoneNumber = userPhoneNumber;

  get getUserBirthday => _userBirthday;
  set setUserBirthday(userBirthday) => _userBirthday = userBirthday;

  get getBirthplace => _userBirthplace;
  set setBirthplace(userBirthplace) => _userBirthplace = userBirthplace;

  UserModel(
      {required userID,
      required userUserName,
      required userFirstName,
      required userLastName,
      required userEmail,
      required userPassword,
      required userPhoneNumber,
      required userImageURL,
      required userBirthday,
      required userBirthplace})
      : _userID = userID,
        _userUserName = userUserName,
        _userFirstName = userFirstName,
        _userLastName = userLastName,
        _userEmail = userEmail,
        _userPassword = userPassword,
        _userPhoneNumber = userPhoneNumber,
        _userImageURL = userImageURL,
        _userBirthplace = userBirthplace,
        _userBirthday = userBirthday;
}
