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
    class Player
    {
        
        public Texture2D texture, bulletTexture, crosshair, GameOver, shieldTex;
        public Vector2 GOpos;
        public Vector2 position;
        public Vector2 CrossHairPos;
        public Vector2 shieldPos;
        public float ShieldCharge;
        public int speed;
        public bool isColliding;
        public Rectangle boundingBox;
        public float bulletDelay;
        public List<Bullet> bulletList;
        public float rotationz;
        public float angle;
        public float HP;
        public Vector2 orig = new Vector2();
        public Vector2 CHorig = new Vector2();
        public bool ShootDelay;
        public int PlayerScore;
        public SpriteFont playerScoreFont;
        public SpriteFont HpFont;
        public SpriteFont shieldChargeFont;
        public Vector2 PlayerScorePos;
        public Vector2 HPpos;
        public Vector2 SPos;
        public bool shieldActive;
        public Rectangle shieldBox;
        public float shieldRegen;



        //constructor
        public Player()
        {
            shieldActive = false;
            ShieldCharge = 100;
            texture = null;
            shieldPos = new Vector2(3000, 3000);
            position = new Vector2(400, 700);
            GOpos = new Vector2(3000, 3000);
            speed = 7;
            isColliding = false;
            bulletDelay = 10;
            bulletList = new List<Bullet>();
            ShootDelay = false;
            HP = 10;
            shieldRegen = .2f;

            PlayerScore = 0;
            
            playerScoreFont = null;
            shieldChargeFont = null;
            PlayerScorePos = new Vector2(200, 10);
            HPpos = new Vector2(10, 10);
            SPos = new Vector2(10, 30);
            HpFont = null;
            
        }

        //loadcontent
        public void LoadContent(ContentManager Content)
        {
            texture = Content.Load<Texture2D>("spaceship");
            shieldTex = Content.Load<Texture2D>("shield");
            bulletTexture = Content.Load<Texture2D>("bullet");
            crosshair = Content.Load<Texture2D>("crosshair");
            GameOver = Content.Load<Texture2D>("GameOver");
            playerScoreFont = Content.Load<SpriteFont>("CooperBlack");
            HpFont = Content.Load<SpriteFont>("CooperBlack");
            shieldChargeFont = Content.Load<SpriteFont>("CooperBlack");
        }
        //draw
        public void draw(SpriteBatch spriteBatch)
        {
            spriteBatch.Draw(texture, position, null, Color.White, rotationz,orig,1.0f,SpriteEffects.None,0);
            spriteBatch.DrawString(HpFont, "Health: " + HP, HPpos, Color.Red);
            if (ShieldCharge == 100)
            {
                spriteBatch.DrawString(shieldChargeFont, "Shield (READY TO DEPLOY): " + Math.Round(ShieldCharge) + "%", SPos, Color.Green);
            }
            else
            {
                spriteBatch.DrawString(shieldChargeFont, "Shield (RECHARGING): " + Math.Round(ShieldCharge) + "%", SPos, Color.Red);
            }
            
            spriteBatch.Draw(shieldTex, shieldPos, Color.White);
            spriteBatch.Draw(crosshair, CrossHairPos, Color.White);
            foreach (Bullet b in bulletList)
            {
                b.Draw(spriteBatch);
            }
            spriteBatch.Draw(GameOver, GOpos, Color.White);
            spriteBatch.DrawString(playerScoreFont, "Score: " + PlayerScore, PlayerScorePos, Color.Red);
            

        }

        //update 
        public void Update(GameTime gameTime)
        {
            
            orig.X = texture.Width / 2;
            orig.Y = texture.Height / 2;
            CHorig.X = crosshair.Width / 2;
            CHorig.Y = crosshair.Height / 2;

            if (HP <= 0)
            {
                GOpos.X = 100;
                GOpos.Y = 100;
            }
            
            MouseState mouseState = new MouseState();
            mouseState = Mouse.GetState();
            KeyboardState keyState = Keyboard.GetState();
            //player collision
            boundingBox = new Rectangle((int)position.X - texture.Width /2, (int)position.Y - texture.Height /2, texture.Width, texture.Width);
            shieldBox = new Rectangle((int)shieldPos.X, (int)shieldPos.Y, shieldTex.Width, shieldTex.Height);
            
            //controls
            if (keyState.IsKeyDown(Keys.W))
            {
                position.Y -= speed;
            }
            if (keyState.IsKeyDown(Keys.S))
            {
                position.Y += speed;
            }
            if (keyState.IsKeyDown(Keys.A))
            {
                position.X -= speed;
            }
            if (keyState.IsKeyDown(Keys.D))
            {
                position.X += speed;
            }

            if (mouseState.RightButton == ButtonState.Pressed)
            {
                if (ShieldCharge == 100)
                {
                    shieldActive = true;
                }
                
            }
            
            if (mouseState.LeftButton == ButtonState.Pressed)
            {
                Shoot();
            }

            if (!shieldActive)
            {
                shieldPos.X = 3000;
                shieldPos.Y = 3000;
            }


          
            updateBullet();

            if (shieldActive && ShieldCharge > 0)
            {
                ShieldCharge -= 1;
                shieldPos.X = position.X - 50;
                shieldPos.Y = position.Y - 50;
            }
            if (ShieldCharge != 100 && !shieldActive)
            {
                ShieldCharge += .5f;
                
            }
            if (ShieldCharge <= 0)
            {
                shieldActive = false;
            }

           //experimental rotation
            
            CrossHairPos = new Vector2(mouseState.X + CHorig.X, mouseState.Y + CHorig.Y);

            Vector2 mouseLock = new Vector2(mouseState.X + CHorig.X , mouseState.Y + CHorig.Y);
            Vector2 dir = new Vector2(position.X - orig.X, position.Y - orig.Y) - mouseLock;
            angle = (float)(Math.Atan2(dir.Y, dir.X));
            rotationz = angle + 30;
            

            //screen boundaries

            if (position.X <= 0 + texture.Width /2)
            {
                position.X = 0 + texture.Width /2;
            }
            if (position.X >= 800 - texture.Width /2)
            {
                position.X = 800 - texture.Width /2;
            }
            if (position.Y <= 0 + texture.Height /2)
            {
                position.Y = 0 + texture.Height /2;
            }
            if (position.Y >= 800- texture.Height /2)
            {
                position.Y = 800 - texture.Height /2;
            }

        }

        //shoot
        public void Shoot()
        {
            //delay
            if (bulletDelay >= 0)
            {
                bulletDelay--;
            }
            if (bulletDelay <= 0)
            {
                Bullet newBullet = new Bullet(bulletTexture);
                newBullet.position = new Vector2(position.X - newBullet.texture.Width /2, position.Y - texture.Width /2);
                bulletDelay = 10;
                newBullet.isVisible = true;

                if (bulletList.Count() <= 10)
                {
                    bulletList.Add(newBullet);
                }

                ShootDelay = false;
            }

            //reset delay
            if (bulletDelay == 0)
            {
                bulletDelay = 10;
            }
        }

        //update bullet
        public void updateBullet()
        {


            //for each bullet update movement
            foreach (Bullet b in bulletList)
            {
                b.boundingBox = new Rectangle((int)b.position.X, (int)b.position.Y, b.texture.Width, b.texture.Height);

                //b.position.Y = b.position.Y - b.speed;
                b.position.X += (CrossHairPos.X - position.X / CrossHairPos.X + CHorig.X - position.X) / 10;
                b.position.Y += (CrossHairPos.Y - position.Y / CrossHairPos.Y + CHorig.Y - position.Y) / 10;

                if (b.position.Y <= 0 || b.position.Y >= 800 || b.position.X <=0 || b.position.X >= 800)
                {
                    b.isVisible = false;
                }
            }
            for (int i = 0; i < bulletList.Count; i++)
            {
                
                bulletList[i].position.Y += (CrossHairPos.Y - position.Y) / 30;
                if (!bulletList[i].isVisible)
                {
                    bulletList.RemoveAt(i);
                    i--;
                }
            }
        }
    }
}
