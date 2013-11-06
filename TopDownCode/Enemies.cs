using System;
using System.Collections.Generic;
using System.Linq;
using Microsoft.Xna.Framework;
using Microsoft.Xna.Framework.Audio;
using Microsoft.Xna.Framework.Content;
using Microsoft.Xna.Framework.GamerServices;
using Microsoft.Xna.Framework.Graphics;
using Microsoft.Xna.Framework.Input;
using Microsoft.Xna.Framework.Media;

namespace _2D_Shooter
{
    public class Enemies
    {
        public Texture2D texture;
        public Vector2 position;
        public Vector2 origin;
        public float rotationAngle;
        public int speed;
        public bool isColliding;
        public bool Destroyed;

        //constructor

        public Enemies()
        {
            position = new Vector2(400, -50);
            texture = null;
            speed = 4;
            isColliding = false;
            Destroyed = false;

        }

        //loadcontent
        public void LoadContent(ContentManager Content)
        {
            texture = Content.Load<Texture2D>("");
        }

    }
}
