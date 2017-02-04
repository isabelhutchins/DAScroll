
//
//  EditorialViewController.m
//  DAScroll
//
//  Created by bhutchins on 2/12/16.
//  Copyright © 2016 Anthony Jonikas. All rights reserved.
//Bella Hutchins and Anthony Jonikas

#import "EditorialViewController.h"
#import "gridTabViewController.h"

@interface EditorialViewController ()
@property (nonatomic, strong) IBOutlet UITextView *textView;
@property (nonatomic, strong) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) NSMutableAttributedString *titleAndContent; //an array of all information from an article
@property (nonatomic, strong) NSMutableArray *articles; //an array of all the articles
@property int indexOfArticle;
@property (nonatomic, strong) IBOutlet UIButton *textSize;
@property (nonatomic, strong) NSMutableArray *photoURLS;
@property int size;
@property int loadedArticles;


@end

@implementation EditorialViewController


-(id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
     _photoURLS = [[NSMutableArray alloc] init];
    _titleAndContent = [[NSMutableAttributedString alloc]initWithString:@""];
    _articles = [[NSMutableArray alloc]init];
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    _loadedArticles = 2;
    if (self) {//cycles through 5 pages of the deerfieldscroll API
        //this chunk of text is the URLRequest
        for (int i = 1; i < 2; i++){
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
            _size = 15;
            NSString *websiteURL = [NSString stringWithFormat:@"http://www.deerfieldscroll.com/wp-json/posts/?page=%i", i];
            [request setURL:[NSURL URLWithString:websiteURL]];
            //we aren't sure how to manage this error/how it works yet
            NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:NULL error:NULL];
            NSError *error = nil;
            
            //all the info from the API is stored in a huge array, each article (and all the info that comes with it)
            //has it's own index
            NSArray *jsonDataArray = [[NSArray alloc] initWithArray:[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error]]; //NSJSONSerializatoin is a built in parser.
            
                   //this is the process of parsing
            for (int j=0; j<jsonDataArray.count; j++){
                NSDictionary *dictObject = [jsonDataArray objectAtIndex:j];
                
             //accessing the name of the section (ex: Front page, Opinion, etc)
                NSDictionary *terms = [[NSDictionary alloc]initWithDictionary:[dictObject objectForKey:@"terms"]];
                NSArray *category = [[NSArray alloc]initWithArray:[terms objectForKey:@"category"]];
                NSDictionary *itemsInCategory=[category objectAtIndex:0];
                NSString *sectionName = [itemsInCategory objectForKey:@"name"];
                
                if ([sectionName isEqualToString:@"Editorial"]){
                    //accessing the title
                    
                    NSString *title = [dictObject objectForKey:@"title"];
                    // NSLog(@"%@", title);
                    title = [NSString stringWithFormat:@"%@\n\n", title];
                    title = [title stringByReplacingOccurrencesOfString:@"&#8217;"
                                                             withString:@"'"];
                    title = [title stringByReplacingOccurrencesOfString:@"&#8230;"
                                                             withString:@"..."];
                    
                    //accessing the content
                    NSString *content = [dictObject objectForKey:@"content"];
                    //formatting edits
                    content = [content stringByReplacingOccurrencesOfString:@"<p>"
                                                                 withString:@"        "];
                    
                    content = [content stringByReplacingOccurrencesOfString:@"<p class=“p1”>"
                                                                 withString:@"        "];
                    
                    content = [content stringByReplacingOccurrencesOfString:@"&#8230;"
                                                                 withString:@"..."];
                    
                    
                    NSMutableString *mutableContent = [content mutableCopy];//convert to mutableString
                    
                    //this gets rid of all unwanted bracketed phrases and photo links leftover in the content from the API
                    NSRegularExpression *regex = [NSRegularExpression
                                                  regularExpressionWithPattern:@"\\<.+?\\>"
                                                  options:NSRegularExpressionCaseInsensitive
                                                  error:NULL];
                    
                    [regex replaceMatchesInString:mutableContent
                                          options:0
                                            range:NSMakeRange(0, [mutableContent length])
                                     withTemplate:@""];
                    
                    content = [NSString stringWithString:mutableContent];//convert back to regular string
                    
                    
                    //accessing photos
                    if ([dictObject objectForKey:@"featured_image"]==[NSNull null]){
                        NSLog(@"nil");
                        [_photoURLS addObject:[NSNull null]];
                    }else{
                        NSDictionary *featuredImage = [[NSDictionary alloc]initWithDictionary:[dictObject objectForKey:@"featured_image"]];
                        NSString *photoLink = [featuredImage objectForKey:@"guid"];
                        photoLink = [photoLink stringByReplacingOccurrencesOfString:@"\\"
                                                                         withString:@""];
                        [_photoURLS addObject:photoLink];
                    }
                    
                    
                    //make Mutable Attributed Strings of the content and the titles
                    NSMutableAttributedString *atrTitles = [[NSMutableAttributedString alloc]initWithString:title attributes:@{NSFontAttributeName : [UIFont fontWithName:@"Helvetica-Bold" size:30]}];
                    NSMutableAttributedString *mutAtContent = [[NSMutableAttributedString alloc]initWithString:content];
                    //combine everything into one MutableAttributedString
                    [atrTitles appendAttributedString:mutAtContent];
                    [_articles addObject:atrTitles];
                }
                
            }
        }
    }
    return self;
    
    
}
//this button moves the user back to the home screen
-(IBAction)pushMyNewViewController:(id)sender
{
   //pops the new view off rather than creating a new home screen
     [self dismissViewControllerAnimated:YES completion:nil];
   
}

-(void) updateForArticles
{
    for (int i = _loadedArticles; i < _loadedArticles+2; i++){
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        _size = 15;
        NSString *websiteURL = [NSString stringWithFormat:@"http://www.deerfieldscroll.com/wp-json/posts/?page=%i", i];
        [request setURL:[NSURL URLWithString:websiteURL]];
        //we aren't sure how to manage this error/how it works yet
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:NULL error:NULL];
        NSError *error = nil;
        
        //all the info from the API is stored in a huge array, each article (and all the info that comes with it)
        //has it's own index
        NSArray *jsonDataArray = [[NSArray alloc] initWithArray:[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error]]; //NSJSONSerializatoin is a built in parser.
        
        //this is the process of parsing
        for (int j=0; j<jsonDataArray.count; j++){
            NSDictionary *dictObject = [jsonDataArray objectAtIndex:j];
            
            //accessing the name of the section (ex: Front page, Opinion, etc)
            NSDictionary *terms = [[NSDictionary alloc]initWithDictionary:[dictObject objectForKey:@"terms"]];
            NSArray *category = [[NSArray alloc]initWithArray:[terms objectForKey:@"category"]];
            NSDictionary *itemsInCategory=[category objectAtIndex:0];
            NSString *sectionName = [itemsInCategory objectForKey:@"name"];
            
            if ([sectionName isEqualToString:@"Editorial"]){
                //accessing the title
                
                NSString *title = [dictObject objectForKey:@"title"];
                // NSLog(@"%@", title);
                title = [NSString stringWithFormat:@"%@\n\n", title];
                title = [title stringByReplacingOccurrencesOfString:@"&#8217;"
                                                         withString:@"'"];
                title = [title stringByReplacingOccurrencesOfString:@"&#8230;"
                                                         withString:@"..."];
                
                //accessing the content
                NSString *content = [dictObject objectForKey:@"content"];
                //formatting edits
                content = [content stringByReplacingOccurrencesOfString:@"<p>"
                                                             withString:@"        "];
                
                content = [content stringByReplacingOccurrencesOfString:@"<p class=“p1”>"
                                                             withString:@"        "];
                
                content = [content stringByReplacingOccurrencesOfString:@"&#8230;"
                                                             withString:@"..."];
                
                
                NSMutableString *mutableContent = [content mutableCopy];//convert to mutableString
                
                //this gets rid of all unwanted bracketed phrases and photo links leftover in the content from the API
                NSRegularExpression *regex = [NSRegularExpression
                                              regularExpressionWithPattern:@"\\<.+?\\>"
                                              options:NSRegularExpressionCaseInsensitive
                                              error:NULL];
                
                [regex replaceMatchesInString:mutableContent
                                      options:0
                                        range:NSMakeRange(0, [mutableContent length])
                                 withTemplate:@""];
                
                content = [NSString stringWithString:mutableContent];//convert back to regular string
                
                
                //accessing photos
                if ([dictObject objectForKey:@"featured_image"]==[NSNull null]){
                    NSLog(@"nil");
                    [_photoURLS addObject:[NSNull null]];
                }else{
                    NSDictionary *featuredImage = [[NSDictionary alloc]initWithDictionary:[dictObject objectForKey:@"featured_image"]];
                    NSString *photoLink = [featuredImage objectForKey:@"guid"];
                    photoLink = [photoLink stringByReplacingOccurrencesOfString:@"\\"
                                                                     withString:@""];
                    [_photoURLS addObject:photoLink];
                }
                
                
                //make Mutable Attributed Strings of the content and the titles
                NSMutableAttributedString *atrTitles = [[NSMutableAttributedString alloc]initWithString:title attributes:@{NSFontAttributeName : [UIFont fontWithName:@"Helvetica-Bold" size:30]}];
                NSMutableAttributedString *mutAtContent = [[NSMutableAttributedString alloc]initWithString:content];
                //combine everything into one MutableAttributedString
                [atrTitles appendAttributedString:mutAtContent];
                [_articles addObject:atrTitles];
            }}}
    _loadedArticles = _loadedArticles + 2;
}

-(void) viewDidAppear:(BOOL)animated
{
    [self.textView setContentOffset: CGPointMake(0, -self.textView.contentInset.top) animated:NO];
}

//in order to use the "next" and "previous" buttons, we store all the articles in an array
-(IBAction)nextArticle:(id)sender
{
    [self updateForArticles];
    if ((_indexOfArticle+1) < ([_articles count]-1)){
        _indexOfArticle=_indexOfArticle+1;
        _textView.attributedText=[_articles objectAtIndex:_indexOfArticle];
        if ([_photoURLS objectAtIndex:_indexOfArticle]!=[NSNull null]){
            UIImage *image2 = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[_photoURLS objectAtIndex:_indexOfArticle]]]];
            _imageView.image = image2;
        }else{
            NSLog(@"No photo for article");
            _imageView.image = [UIImage imageNamed:@"deerfield seal.png"];
        }
    }
}

//allows the user to change the font size
-(IBAction) changeTheFontSize:(id) sender
{
    _textView.font = [UIFont fontWithName:@"Helvetica Light" size:_size+1];
    if (_size>30)
        _size = 15;
    _size = _size +1;
}

-(IBAction)previousArticle:(id)sender
{
    if (_indexOfArticle>=1){
        _indexOfArticle=_indexOfArticle-1;
        _textView.attributedText=[_articles objectAtIndex:_indexOfArticle];
        if ([_photoURLS objectAtIndex:_indexOfArticle]!=[NSNull null]){
            UIImage *image2 = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[_photoURLS objectAtIndex:_indexOfArticle]]]];
            _imageView.image = image2;
        }else{
            NSLog(@"No photo for article");
            _imageView.image = [UIImage imageNamed:@"deerfield seal.png"];
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _textView.font = [UIFont fontWithName:@"Helvetica Light" size:_size];
    _textView.editable = NO; //keeps user from being able to edit articles
    _indexOfArticle=1;
    _textView.attributedText=[_articles objectAtIndex:0];
    
    
    if ([_photoURLS objectAtIndex:0]!=[NSNull null]){
        UIImage *image2 = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[_photoURLS objectAtIndex:0]]]];
        _imageView.image = image2;
    }else{
        NSLog(@"No photo for article.");
        _imageView.image = [UIImage imageNamed:@"deerfield seal.png"];
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
