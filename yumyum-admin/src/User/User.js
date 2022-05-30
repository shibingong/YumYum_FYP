import React, { useEffect, useState, setState } from 'react';
import axios from 'axios';
import { useParams } from 'react-router-dom';
import { getToken, removeUserSession } from '../utils/Common';

function User(props) {
  const [user, getUser] = useState('');
  const { id } = useParams();
  let tkn;
  // console.log(id);
  // console.log(user);

  const [name, setName] = useState('');
  const [email, setEmail] = useState('');
  const [address, setAddress] = useState('');

  useEffect(() => {
    tkn = getToken();
    axios.get('http://localhost:3000/user/'+id, {
      headers: {
        Authorization: 'Bearer ' + tkn
      }
    }).then(response => {
      getUser(response.data);
      setName(response.data.name);
      setEmail(response.data.email);
      setAddress(response.data.address);
    }).catch(error => {
      console.error(`Error: ${error}`);
    });
  }, []);

  

  const handleOnClick = () => {
    // console.log(name);
    // console.log(email);
    // console.log(address);
    tkn = getToken();
    console.log(tkn);
    axios.put('http://localhost:3000/user/'+id, { name: name, email: email, address: address }, {
      headers: {
        Authorization: 'Bearer ' + tkn
      }
    }).then(response => {
      window.location.href = '/';
    }).catch(error => {
      console.error(`Error: ${error}`);
    });
  }

  return (
    <div>
        <div className="row d-flex justify-content-center align-items-center h-100 ">
          <div className="col-lg-6">
            <div className="card-body p-md-5 mx-md-4">

              <div className="text-center">
                <h4 className="mt-1 mb-5 pb-1">Edit User</h4>
              </div>

              <form>

                <div className="form-group mb-4">
                <label for="lblNameInput">Name</label>
                  <input type="text" className="form-control"
                    placeholder="name" value={name} onChange={(e) => setName(e.target.value)}  id='nameInput'/>
                </div>

                <div className="form-group mb-4">
                <label for="lblEmailInput">Email address</label>
                  <input type="text" className="form-control" placeholder='email' value={email} onChange={(e) => setEmail(e.target.value)} id='emailInput'/>
                </div>

                <div className="form-group mb-4">
                <label for="lblAddressInput">Address</label>
                  <input type="text" className="form-control" placeholder='address' value={address} onChange={(e) => setAddress(e.target.value)} id='addressInput'/>
                </div>

                <div className="text-center pt-1 mb-5 pb-1">
                  <input type="button" className="btn btn-primary btn-block fa-lg gradient-custom-2 mb-3" value= 'Edit' onClick={handleOnClick}/>
                </div>

              </form>

            </div>
          </div>
        </div>
    </div>
  );
}

// const useFormInput = initialValue => {
//   const [value, setValue] = useState(initialValue);

//   const handleChange = e => {
//     setValue(e.target.value);
//   }
//   return {
//     value,
//     onChange: handleChange
//   }
// }

export default User;