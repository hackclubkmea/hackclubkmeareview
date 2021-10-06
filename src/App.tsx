import { useEffect, useState } from "react";
import "./App.css";
import logo_github from "./images/github.png";
export default function App() {
  const [reviewData, setReviewData] = useState<ReviewComponentProps[] | []>([]);
  useEffect(() => {
    async function fetchData() {
      const response = await fetch(
        "https://raw.githubusercontent.com/hackclubkmea/hackclubkmeareview/main/review.json"
      );
      const data = await response.json();
      const dataArray = Object.keys(data).map((key) => data[key]);
      setReviewData(dataArray);
    }
    fetchData();
  }, []);
  return (
    <div className="app__container">
      <div className="app_review__component">
        {reviewData.map((review, index) => (
          <ReviewComponent {...review} key={index} />
        ))}
      </div>
    </div>
  );
}

interface ReviewComponentProps {
  name: string;
  github: string;
  review: string;
}

export const ReviewComponent = ({
  name,
  github,
  review,
}: ReviewComponentProps) => {
  return (
    <div className="review">
      <div className="review__component_name_and_avatar">
        <div className="avatar_component">
          <img src={`${github}.png`} alt={"Github profile image of " + name} />
        </div>
        <div className="name_and_logo">
          <a href={github} target="_blank" rel="noopener noreferrer">
            <img src={logo_github} alt="Github Logo" />
            <div>
              <strong>{name}</strong>
            </div>
          </a>
        </div>
      </div>
      <div className="review__concent">{review}</div>
    </div>
  );
};
