a = array_create(16, infinity);

apiUrlPrefix = "https://identitytoolkit.googleapis.com/v1/";
apiUrlSuffix = "?key=AIzaSyC1ovEqMkBgvEYkrjFCDBWsk0soFkk-ygI";

functionUrlPrefix = "https://us-central1-escape-3db6a.cloudfunctions.net/";

//authentication data including the current user (refresh token is saved locally so you can instantly sign in)
authToken = "";
refreshToken = "";

//todo: make all post requests protected by anticheat w/ an external client that validates the input data sent along with
//the result
enum request {
    death,
    completion,
    register, //register: gives u a token, but you now need to verify your email
    login, //login: only allows you in if you have your email verified
    update, //update profile
    verify, //verify email
}

//store transient information about the current HTTP request
reqID = undefined;
reqType = undefined;