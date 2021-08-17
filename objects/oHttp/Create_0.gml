a = array_create(16, infinity);

apiUrlPrefix = "https://identitytoolkit.googleapis.com/v1/";
apiUrlSuffix = "?key=AIzaSyC1ovEqMkBgvEYkrjFCDBWsk0soFkk-ygI";
tokenUrlPrefix = "https://securetoken.googleapis.com/v1/";

functionUrlPrefix = "https://us-central1-escape-3db6a.cloudfunctions.net/";

//authentication data including the current user (refresh token is saved locally so you can instantly sign in)
authToken = "";
refreshToken = "";
user = "";

//todo: make all post requests protected by anticheat w/ an external client that validates the input data sent along with
//the result
enum request {
    death,
    completion,
    register, //register: gives u a token, but you now need to verify your email
    login, //login: only allows you in if you have your email verified
    update, //update profile
    verify, //check if email is verified
    verificationEmail, //send a verification email
    resetEmail, //send a password reset email
}

//store transient information about the current HTTP request
reqID = undefined;
reqType = undefined;

//also maintain these variables with a global scope
isRegistering = false;
res = undefined;

//important: don't rely on oPersistent.canInteract to determine whether nor not you can interact with stuff
//instead, create a new variable that shows when you are requesting something critical (i.e. not logging a 
//death/completion); that will stop u from interacting if reqImportant is true
reqImportant = false;

//refresh requests run independent of the current request
refreshID = undefined;