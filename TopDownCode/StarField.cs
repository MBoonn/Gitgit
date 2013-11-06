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
    public class StarField
    {
        public Texture2D texture;
        public Vector2 BgPos1, BgPos2;
        public int speed;

        //constructor
        public StarField()
        {
            texture = null;
            BgPos1 = new Vector2(0, 0);
            BgPos2 = new Vector2(0, -800);
            speed = 1;
        }

        //loadcontent

        public void LoadContent(ContentManager Content)
        {
            texture = Content.Load<Texture2D>("space2");
        }

        //draw

        public void Draw(SpriteBatch spriteBatch)
        {
            spriteBatch.Draw(texture, BgPos1, Color.White);
            spriteBatch.Draw(texture, BgPos2, Color.White);

        }

        //update

        public void Update(GameTime gameTime)
        {
            BgPos1.Y += speed;
            BgPos2.Y += speed;

            //scroll
            if (BgPos1.Y >= 800)
            {
                BgPos1.Y = 0;
                BgPos2.Y = -800;
            }
        }

    }
}
