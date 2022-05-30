import React, { useEffect, useState } from 'react';
import axios from 'axios';
import { getToken, removeUserSession } from '../utils/Common';
import { Link, useParams } from 'react-router-dom';

function Recipes(props) {
    const [recipes, getRecipes] = useState('');
    const { id } = useParams();

    console.log(recipes);

    useEffect(() => {
        let tkn = getToken();
        axios.get('http://localhost:3000/recipe/user/' + id, {
            headers: {
                Authorization: 'Bearer ' + tkn
            }
        }).then(response => {
            // console.log(response.data);
            getRecipes(response.data);
        }).catch(error => {
            console.error(`Error: ${error}`);
        });
    }, []);

    return (
        <div>
            <h3 className="p-3 text-center">Recipes Table</h3>
            <table className="table table-striped table-bordered">
                <thead>
                    <tr>
                        <th>Name</th>
                        <th>Description</th>
                        <th>Types</th>
                        <th>Ingredients</th>
                        <th>Steps</th>
                        <th>Nutrition</th>
                        <th>Video Url</th>
                    </tr>
                </thead>
                <tbody>
                    {recipes!==''?
                    recipes && recipes.map(recipe =>
                        <tr key={recipe._id}>
                            <td>{recipe.recipeName}</td>
                            <td>{recipe.recipeDescription}</td>
                            <td><ul>{recipe.types.map(type => <li>{type}</li>)}</ul></td>
                            <td><ol>{recipe.steps.map(step => <li>{step}</li>)}</ol></td>
                            <td><ul>{recipe.ingredients.map(ingredient => <li>{ingredient}</li>)}</ul></td>
                            <td><ul>
                                <li>calories: {recipe.nutrition.calories}</li>
                                <li>sugar: {recipe.nutrition.sugar}g</li>
                                <li>fiber: {recipe.nutrition.fiber}g</li>
                                <li>sodium: {recipe.nutrition.sodium}mg</li>
                                <li>fat: {recipe.nutrition.fat}g</li>
                                </ul></td>
                            {/* <td> <Link to={{ pathname: `/user/${user._id}`, state: user._id }} className="btn btn-primary" >Edit</Link> <button type="button" className="btn btn-danger" >Delete</button> </td> */}
                            <td>{recipe.videoUrl !== '' ?
                                <a href={recipe.videoUrl}>{recipe.videoUrl}</a>
                                : "-"
                            }

                            </td>
                        </tr>
                    ):
                    <tr><td colSpan={7} className="text-center">No Recipes</td></tr>
                    }
                </tbody>
            </table>

        </div>

    );
}

export default Recipes;