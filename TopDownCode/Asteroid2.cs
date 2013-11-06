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
    public class Asteroid2
    {
        public Rectangle boundingBox;
        public Texture2D texture;
        public Vector2 position;
        public Vector2 origin;
        public float rotationAngle;
        public int speed;
        public bool isVisible;





        //constructor

        public Asteroid2(Texture2D newTexture, Vector2 newPos)
        {

            texture = newTexture;
            position = newPos;
            isVisible = true;
            speed = 4;


        }

        //loadcontent
        public void LoadContent(ContentManager Content)
        {


        }

        //updaate

        public void Update(GameTime gameTime)
        {
            boundingBox = new Rectangle((int)(position.X - (texture.Width / 2)), (int)(position.Y - (texture.Height / 2)), texture.Width, texture.Height);
            origin.X = texture.Width / 2;
            origin.Y = texture.Height / 2;

            //movement
            position.Y += speed;

            

            if (position.Y >= 800)
            {
                isVisible = false;
            }
        }

        //draw

        public void Draw(SpriteBatch spriteBatch)
        {
            if (isVisible)
            {
                spriteBatch.Draw(texture, position, null, Color.White, rotationAngle, origin, 1.0f, SpriteEffects.None, 0f);
            }

        }
    }
}
