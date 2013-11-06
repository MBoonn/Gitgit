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
  
    public class Game1 : Microsoft.Xna.Framework.Game
    {
        GraphicsDeviceManager graphics;
        SpriteBatch spriteBatch;
        Random random = new Random();
        List<Asteroid> asteList = new List<Asteroid>();
        List<Asteroid2> asteList2 = new List<Asteroid2>();
        Player P = new Player();
        StarField SF = new StarField();
        public int timer;
        

        public Game1()
        {
            graphics = new GraphicsDeviceManager(this);
            Content.RootDirectory = "Content";
            graphics.IsFullScreen = false;
            graphics.PreferredBackBufferWidth = 800;
            graphics.PreferredBackBufferHeight = 800;
            this.Window.Title = "Space Shooter -----  CONTROLS: WASD + MOUSE AND MOUSEBUTTONS ----- Made by Mike Boon";


        }

     
        protected override void Initialize()
        {
            // TODO: Add your initialization logic here

            base.Initialize();
        }

       
        protected override void LoadContent()
        {
            
            spriteBatch = new SpriteBatch(GraphicsDevice);
            P.LoadContent(Content);
            SF.LoadContent(Content);

            // TODO: use this.Content to load your game content here
        }

        protected override void UnloadContent()
        {
            // TODO: Unload any non ContentManager content here
        }

        /// <param name="gameTime">Provides a snapshot of timing values.</param>
        protected override void Update(GameTime gameTime)
        {
            // Allows the game to exit
            if (P.HP <= 0)
            {
                P.GOpos.X = 0;
                P.GOpos.Y = 0;
                P.PlayerScorePos.X = 400;
                P.PlayerScorePos.Y = 500;
            }
            if (P.HP > 0)
            {

                if (GamePad.GetState(PlayerIndex.One).Buttons.Back == ButtonState.Pressed)
                    this.Exit();

                P.Update(gameTime);
                SF.Update(gameTime);
                foreach (Asteroid a in asteList)
                {
                    if (a.boundingBox.Intersects(P.boundingBox))
                    {
                        a.isVisible = false;
                        if (!P.shieldActive)
                        {
                            P.HP -= 1;
                        }
                        
                    }
                    a.Update(gameTime);

                    for (int i = 0; i < P.bulletList.Count; i++)
                    {
                        if (a.boundingBox.Intersects(P.bulletList[i].boundingBox))
                        {
                            a.isVisible = false;
                            P.PlayerScore += 10;

                            P.bulletList.ElementAt(i).isVisible = false;
                        }
                    }
                }

                LoadAsteroids();

                foreach (Asteroid2 a2 in asteList2)
                {
                    if (a2.boundingBox.Intersects(P.boundingBox))
                    {

                        a2.isVisible = false;
                        if (!P.shieldActive)
                        {
                            P.HP -= 1;
                        }
                        
                        
                    }
                    a2.Update(gameTime);

                    for (int i = 0; i < P.bulletList.Count; i++)
                    {
                        if (a2.boundingBox.Intersects(P.bulletList[i].boundingBox))
                        {
                            a2.isVisible = false;
                            P.bulletList.ElementAt(i).isVisible = false;
                            P.PlayerScore += 1;
                        }
                    }
                }

                LoadAsteroids2();

            }
            base.Update(gameTime);
        }

        /// <param name="gameTime">Provides a snapshot of timing values.</param>
        protected override void Draw(GameTime gameTime)
        {
            GraphicsDevice.Clear(Color.CornflowerBlue);
            spriteBatch.Begin();
            
            SF.Draw(spriteBatch);
            

            foreach(Asteroid a in asteList)
            {
                a.Draw(spriteBatch);
            }
            foreach (Asteroid2 a2 in asteList2)
            {
                a2.Draw(spriteBatch);
            }

            P.draw(spriteBatch);
           
           

            spriteBatch.End();

            // TODO: Add your drawing code here

            base.Draw(gameTime);
        }

        //loadasteroids

        public void LoadAsteroids()
        {
            int randY = random.Next(-1000, -300);
            int randX = random.Next(50, 750);

            if (asteList.Count() < 10)
            {
                timer++;
                if (timer >= 10)
                {
                    asteList.Add(new Asteroid(Content.Load<Texture2D>("enemy"), new Vector2(randX, randY)));
                    timer = 0;
                }
                
            }
            for (int i = 0; i < asteList.Count; i++)
            {
                if (!asteList[i].isVisible)
                {
                    asteList.RemoveAt(i);
                    i--;
                }
            }

        }

        public void LoadAsteroids2()
        {
            int randY2 = random.Next(-1000, -300);
            int randX2 = random.Next(50, 750);

            if (asteList2.Count() < 4)
            {
                timer++;
                if (timer >= 10)
                {
                    asteList2.Add(new Asteroid2(Content.Load<Texture2D>("asteroid"), new Vector2(randX2, randY2)));
                    timer = 0;
                }

            }
            for (int i = 0; i < asteList2.Count; i++)
            {
                if (!asteList2[i].isVisible)
                {
                    asteList2.RemoveAt(i);
                    i--;
                }
            }

        }

    }
}
