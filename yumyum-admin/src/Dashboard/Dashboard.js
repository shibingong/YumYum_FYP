import React, { useEffect, useState } from 'react';
import axios from 'axios';
import Swal from 'sweetalert2';
import { getToken, removeUserSession } from '../utils/Common';
import { Link } from 'react-router-dom';

function Dashboard(props) {
  const [users, getUsers] = useState('');
  // console.log(users);
  useEffect(() => {
    let tkn = getToken();
    axios.get('http://localhost:3000/user/all', {
      headers: {
        Authorization: 'Bearer ' + tkn
      }
    }).then(response => {
      // console.log(response.data);
      getUsers(response.data);
    }).catch(error => {
      console.error(`Error: ${error}`);
    });
  }, []);


  const handleDelete = (id) => {
    let tkn = getToken();

    Swal.fire({
      title: 'Do you want to delete the user?',
      showCancelButton: true,
      confirmButtonText: 'Yes',
    }).then((result) => {
      if (result.isConfirmed) {
        axios.delete('http://localhost:3000/user/' + id, {
          headers: {
            Authorization: 'Bearer ' + tkn
          }
        }).then(response => {
          // console.log(response.data);
          Swal.fire({
            icon: 'success',
            title: 'Delete Successfully'
          }).then(() => {
            window.location.href = '/';
          })
        }).catch(error => {
          console.error(`Error: ${error}`);
          Swal.fire({
            icon: 'error',
            title: 'Delete Failed'
          })
        });
      }
    })

  }

  return (
    <div>
      <h3 className="p-3 text-center">User Table</h3>
      <table className="table table-striped table-bordered">
        <thead>
          <tr>
            <th>Name</th>
            <th>Email</th>
            <th>Address</th>
            <th>Username</th>
            <th className="text-center">Operation</th>
          </tr>
        </thead>
        <tbody>
          {users !== '' ?
            users && users.map(user =>
              <tr key={user._id}>
                <td>{user.name}</td>
                <td>{user.email}</td>
                <td>{user.address}</td>
                <td>{user.username}</td>
                <td className="text-center"> <Link to={{ pathname: `/user/${user._id}`, state: user._id }} className="btn btn-primary" >Edit</Link> <button type="button" className="btn btn-danger" onClick={() => handleDelete(user._id)} >Delete</button> <Link to={{ pathname: `/recipes/${user._id}`, state: user._id }} className="btn btn-warning" >View Recipes</Link> </td>
              </tr>
            ) :
            <tr><td colSpan={5} className="text-center">No Users</td></tr>
          }
        </tbody>
      </table>

    </div>

  );
}

export default Dashboard;