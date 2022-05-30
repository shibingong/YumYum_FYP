// return the token from the session storage
export const obtainToken = () => {
    return sessionStorage.getItem('token') || null;
  }
   
  export const getToken = () => {
    const tokenString = localStorage.getItem('token');
        const userToken = JSON.parse(tokenString);
        return userToken?.token || null;
  }

  // remove the token and user from the session storage
  export const removeUserSession = () => {
    // sessionStorage.removeItem('token');
    localStorage.removeItem('token');
  }
   
  // set the token and user from the session storage
  export const setUserSession = (token) => {
    sessionStorage.setItem('token', token);
  }